FROM golang

# Set necessary environmet variables needed for our image
ENV CGO_ENABLED=1 \
    GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 

# Install packages
RUN apt update && apt install -y \
  cmake \
  zstd \
  && rm -rf /var/lib/apt/lists/*

# Move to working directory /build
WORKDIR /build
#WORKDIR ${GOPATH}

# Copy and download dependency using go mod
#COPY go.mod .
#COPY go.sum .
#RUN go mod download

# Copy the code into the container
#COPY . .

#RUN go get github.com/wal-g/wal-g
RUN git clone https://github.com/wal-g/wal-g.git
#WORKDIR $GOPATH/src/github.com/wal-g/wal-g
WORKDIR /build/wal-g

RUN make install
RUN make deps
RUN CGO_ENABLED=1 make mysql_build

# Build the application
#RUN go build -o main .

# Move to /dist directory as the place for resulting binary folder
#WORKDIR /dist

# Copy binary from build to main folder
#RUN cp /build/main .

# Export necessary port
#EXPOSE 3000

# Command to run when starting the container
#CMD ["/dist/main"]
CMD ["bash"]
