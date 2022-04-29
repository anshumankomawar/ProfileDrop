package main

import (
    "github.com/gofiber/fiber/v2"
    "backend/config"
    "backend/routes"
)

func main() {
    app := fiber.New()
  
    app.Get("/", func(c *fiber.Ctx) error {
        return c.JSON(&fiber.Map{"data": "Hello from Fiber & mongoDB"})
    })

    configs.ConnectDB()
    configs.CreateIndex(configs.DB, "users")

    //routes
    routes.UserRoute(app)
  
    app.Listen(":6000")
}
