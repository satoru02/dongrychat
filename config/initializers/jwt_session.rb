JWTSessions.encryption_key = "secret"

if Rails.env["development"]
  JWTSessions.token_store = :redis, {
    redis_host: "127.0.0.1",
    redis_port: "6379",
    redis_db_name: "0",
    token_prefix: "jwt_"
  }
else Rails.env["production"]
  JWTSessions.token_store = :redis, {
    redis_host: "127.0.0.1",
    redis_port: "6379",
    redis_db_name: "0",
    token_prefix: "jwt_"
    }
end