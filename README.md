# Kafka 

If start kafka with tls mode need to run script `gen_tls_cert.sh` first.

This has kafka in many config type.
1. `docker-compose-plaintext.yml` Kafka with no authen and no tls certificate.
2. `docker-compose-sasl.yml` Kafka with authenticate (username, password).
3. `docker-compose-sasl-tls.yml` Kafka with authenticate (username, password) and tls certificate encryption.

## Example kcat command

## List all message in topic
```sh
kcat -b "127.0.0.1:19092" -t "test-topic"
```

## List all message with consumer group
```sh
kcat -b "127.0.0.1:19092" -G "my-consumer-group" "test-topic"
```

## Print topic detail
```sh
kcat -b 127.0.0.1:19092 -L
```

## Print topic detail with SASL authen
```sh
kcat -b 127.0.0.1:19092 \
     -X security.protocol=SASL_PLAINTEXT \
     -X sasl.mechanisms=SCRAM-SHA-512 \
     -X sasl.username="user1" \
     -X sasl.password="password1" \
     -L
```

## Print all message in topic with SASL authen
```sh
kcat -b 127.0.0.1:19092 \
     -X security.protocol=SASL_PLAINTEXT \
     -X sasl.mechanisms=SCRAM-SHA-512 \
     -X sasl.username="user1" \
     -X sasl.password="password1" \
     -t "test-topic-sasl"
```


## Print all message in topic with SASL authen and TLS
```sh
kcat -b 127.0.0.1:19092 \
     -X security.protocol=SASL_SSL \
     -X sasl.mechanisms=SCRAM-SHA-512 \
     -X sasl.username="user1" \
     -X sasl.password="password1" \
     -X enable.ssl.certificate.verification=false \
     -t "test-topic-sasl"
```

Consume message with consumer group
```
kcat -b 127.0.0.1:19092 \
     -G "hello-group" \
     -X security.protocol=SASL_SSL \
     -X sasl.mechanisms=SCRAM-SHA-512 \
     -X sasl.username="user1" \
     -X sasl.password="password1" \
     -X enable.ssl.certificate.verification=false \
     "test-topic"
```

## Reference:
- https://github.com/bitnami/containers/blob/main/bitnami/kafka/README.md