package main

import (
    "fmt"

    "github.com/gomodule/redigo/redis"
)

func main() {
    // 接続
    conn, err := redis.Dial("tcp", "localhost:6379")
    if err != nil {
        panic(err)
    }
    defer conn.Close()

    // パブリッシュ
    r, err := redis.Int(conn.Do("PUBLISH", "test", "hello"))
    if err != nil {
        panic(err)
    }
    fmt.Println(r)
}
