from fastapi import FastAPI
import aioredis

REDIS_URL = "redis://cache:6379"

app = FastAPI(title="BIGG-Rec API")
redis = aioredis.from_url("redis://cache", decode_responses=True)


@app.get("/get_epistemoniko_id/{biblio_id}")
async def get_cache(biblio_id: str):
    epistemoniko_id = await redis.get(biblio_id)

    if epistemoniko_id:
        out = {"epistemoniko_id": epistemoniko_id, "biblio_id": biblio_id}
    else:
        out = {"message": "biblio ID not found"}

    return out