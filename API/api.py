from flask import Flask, request, send_file
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
from skimage import data, segmentation, color, io
#from skimage.future import graph
import io as io_lib
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

def graph_based_segmentation(img):
    # Perform Felzenszwalb's efficient graph based image segmentation
    segments = segmentation.felzenszwalb(img, scale=100)

    # Create a rag
   # rag = graph.rag_mean_color(img, segments)

    # Draw the segments on the image
    out = color.label2rgb(segments, img, kind='avg')
    segmented_img = segmentation.mark_boundaries(out, segments, color=(0, 0, 0))

    return segmented_img

@app.route('/segment', methods=['POST'])
def segment_image():
    file = request.files['image']
    image = Image.open(file.stream)  # PIL image
    img = np.array(image)

    segmented_img = graph_based_segmentation(img)

    # Convert the result into PIL image and then to byte array
    pil_img = Image.fromarray((segmented_img * 255).astype(np.uint8))
    byte_arr = io_lib.BytesIO()
    pil_img.save(byte_arr, format='PNG')
    byte_arr = byte_arr.getvalue()

    return send_file(io_lib.BytesIO(byte_arr), mimetype='image/png')

if __name__ == '__main__':
    app.run(debug=True ,host='192.168.1.115', port=5001 ,threaded=True)
