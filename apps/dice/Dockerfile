FROM golang:1.20
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY *.go ./
RUN go build -o /dice-server
EXPOSE 8080
CMD ["/dice-server"]
