from fastapi import FastAPI
from src.posts.router import router as post_router
from src.database import Base, engine

Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(post_router)
