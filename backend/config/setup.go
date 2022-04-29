package configs

import (
    "context"
    "fmt"
    "log"
    "time"
    "go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
    "go.mongodb.org/mongo-driver/x/bsonx"
)

func ConnectDB() *mongo.Client  {
    client, err := mongo.NewClient(options.Client().ApplyURI(EnvMongoURI()))
    if err != nil {
        log.Fatal(err)
    }
  
    ctx, _ := context.WithTimeout(context.Background(), 10*time.Second)
    err = client.Connect(ctx)
    if err != nil {
        log.Fatal(err)
    }

    //ping the database
    err = client.Ping(ctx, nil)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println("Connected to MongoDB")
    return client
}

//Client instance
var DB *mongo.Client = ConnectDB()

//getting database collections
func GetCollection(client *mongo.Client, collectionName string) *mongo.Collection {
    collection := client.Database("golangAPI").Collection(collectionName)
    return collection
}

func CreateIndex(client *mongo.Client, collectionName string) error {
    ctx, cancel := context.
        WithTimeout(context.Background(), 10*time.Second)
    defer cancel()
    db := client.Database("golangAPI")
    indexOpts := options.CreateIndexes().
        SetMaxTime(time.Second * 10)
    // Index to location 2dsphere type.
    pointIndexModel := mongo.IndexModel{
        Options: options.Index().SetBackground(true),
        Keys:    bsonx.MDoc{"location": bsonx.String("2dsphere")},
    }
    pointIndexes := db.Collection(collectionName).Indexes()
    _, err := pointIndexes.CreateOne(
        ctx,
        pointIndexModel,
        indexOpts,
    )
    if err != nil {
        return err
    }
    return nil
}
