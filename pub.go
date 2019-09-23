package main

import (
    "fmt"
 "math/rand"
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
    for{
    var  k = rand.Intn(100)
    r, err := redis.Int(conn.Do("PUBLISH", "channel_1",k ))
    if err != nil {
        panic(err)
    }
    fmt.Println(r)
}}
