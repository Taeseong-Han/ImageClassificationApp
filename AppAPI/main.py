import io
import os
import json
import uuid
import torch
from PIL import Image
from pydantic import BaseModel
import torch.nn.functional as F
import torchvision.models as models
from fastapi import FastAPI, UploadFile

app = FastAPI()

## Resnet 모델 선언
weights = models.ResNet50_Weights.IMAGENET1K_V2
preprocess = weights.transforms()
resnet50 = models.resnet50(weights=weights)
resnet50.eval()

## ImageNet 라벨 선언
with open("./database/label/imagenet_class_index.json", 'r') as f:
    class_idx = json.load(f)  ## {'0': ['n01440764', 'tench']}
    idx_to_label = [class_idx[str(k)][1] for k in range(len(class_idx))]


@app.post('/photo')
async def upload_photo(file: UploadFile):
    UPLOAD_DIR = "./database/photos"
    content = await file.read()  ## 이미지 읽기

    file_name = f"{str(uuid.uuid4())}.jpg"  ## uuid: 랜덤으로 고유 아이디 생성
    with open(os.path.join(UPLOAD_DIR, file_name), "wb") as f:
        f.write(content)

    return {"file_name": file_name}


@app.post('/classify')
async def classify_image(file: UploadFile):
    img_binary = await file.read()

    data_io = io.BytesIO(img_binary)
    image = Image.open(data_io).convert('RGB')
    img_transformed = preprocess(image).unsqueeze(0)

    predict = resnet50(img_transformed)
    probability = F.softmax(predict, dim=1)
    top3_probability, top3_label = torch.topk(probability, 3)

    top3_label = [idx_to_label[i.item()] for i in top3_label.squeeze(0)]
    top3_probability = [round(float(i.item()), 2) for i in top3_probability.squeeze(0)]

    return {'top3_label': top3_label, 'top3_probability': top3_probability}