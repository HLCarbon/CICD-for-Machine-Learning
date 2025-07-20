import gradio as gr
import skops.io as sio

pipe = sio.load(".Model/drug_pipeline.skops", trusted=True)
