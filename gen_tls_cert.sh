# Create a directory for certificates
WORK_DIR="./data-config/kafka/certs"

# Create Root CA key and certificate
openssl genrsa -out "${WORK_DIR}/ca.key" 2048
openssl req -x509 -new -nodes -key "${WORK_DIR}/ca.key" -sha256 -days 3650 -out "${WORK_DIR}/ca.crt" -subj "/CN=Kafka CA"

# Create Kafka server key and CSR
openssl genrsa -out "${WORK_DIR}/kafka.key" 2048
openssl req -new -key "${WORK_DIR}/kafka.key" -out "${WORK_DIR}/kafka.csr" -subj "/CN=kafka"

# Sign the server cert with CA
openssl x509 -req -in "${WORK_DIR}/kafka.csr" -CA "${WORK_DIR}/ca.crt" -CAkey "${WORK_DIR}/ca.key" -CAcreateserial -out "${WORK_DIR}/kafka.crt" -days 3650 -sha256 \
-extfile <(cat <<-EOF
[ v3_req ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = kafka
DNS.2 = localhost
IP.1 = 127.0.0.1
EOF
) -extensions v3_req

# Validate
openssl verify -CAfile "${WORK_DIR}/ca.crt" "${WORK_DIR}/kafka.crt"

# Convert to PEM format (already is if you use .crt/.key, but to be safe)
cat "${WORK_DIR}/kafka.crt" > "${WORK_DIR}/kafka.pem"
cat "${WORK_DIR}/kafka.key" >> "${WORK_DIR}/kafka.pem"