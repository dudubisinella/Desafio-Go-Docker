# Usando uma imagem base leve
FROM golang:alpine3.14 as builder

WORKDIR /app

# Copiando o código fonte para a imagem
COPY . .

# Compilando o código
RUN go build -o /main main.go

## Deploy
## Strach base debian, serve para imagens super mínimas(Que contém apenas um único binários)
FROM scratch

WORKDIR /

# Copiando o executável compilado da primeira imagem
COPY --from=builder /main /main

# Expondo a porta 8080
EXPOSE 8080

# Comando a ser executado quando o container iniciar
CMD ["/main"]
