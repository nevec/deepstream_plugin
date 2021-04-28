#!/bin/bash

# gst-launch-1.0 filesrc location=sample.mp4 ! decodebin ! \
#   nvvideoconvert ! "video/x-raw(memory:NVMM), format=(string)RGBA" ! \
#   dsexample processing-width=160 processing-height=120 ! nvosd ! queue ! \
#   nvvideoconvert ! "video/x-raw, format=(string)RGBA" ! videoconvert ! x264enc ! qtmux ! filesink location=out_dsmotion.mp4
  
# gst-launch-1.0 filesrc location=sample.mp4 ! qtdemux ! h264parse ! nvv4l2decoder ! m.sink_0 nvstreammux name=m batch-size=1 width=1280 height=720 ! nvvideoconvert ! dsexample full-frame=1  ! nvdsosd ! nvvideoconvert ! x264enc ! qtmux ! filesink location=out_dsmotion.mp4

# gst-launch-1.0 filesrc location=sample2.mp4 ! qtdemux ! h264parse ! nvv4l2decoder ! m.sink_0 nvstreammux name=m batch-size=1 width=640 height=360 ! nvvideoconvert ! dsexample full-frame=1  ! nvvideoconvert ! x264enc ! mp4mux name=mux ! filesink location=out_dsmotion.mp4 !  audiotestsrc ! lamemp3enc ! mux.

GST_PLUGIN_PATH=/workspace/gst-dsexample gst-launch-1.0 filesrc location=sample.mp4 ! qtdemux ! h264parse ! nvv4l2decoder ! m.sink_0 nvstreammux name=m batch-size=1 width=640 height=360 ! nvvideoconvert nvbuf-memory-type=nvbuf-mem-cuda-unified  ! 'video/x-raw(memory:NVMM), format=RGBA' ! dsexample full-frame=1 ! nvdsosd ! nvvideoconvert ! x264enc ! qtmux ! filesink location=out.mp4