# クイックスタート

1. ```cp .env.example .env```
2. ```vi .env```
```
AWS_ACCESS_KEY_ID={your access key id}
AWS_SECRET_ACCESS_KEY={your secret access key}
```
3. ```docker-compose up -d```
4. ```docker-compose exec terraform ash```
5. ```cd environment/prod```
6. ```terraform init```
