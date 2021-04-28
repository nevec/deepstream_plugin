#!/bin/bash

GST_PLUGIN_PATH=/workspace/gst-dsexample gst-launch-1.0 filesrc location=sample.mp4 ! qtdemux ! h264parse ! nvv4l2decoder ! m.sink_0 nvstreammux name=m batch-size=1 width=640 height=360 ! nvvideoconvert nvbuf-memory-type=nvbuf-mem-cuda-unified  ! 'video/x-raw(memory:NVMM), format=RGBA' ! dsexample full-frame=1 ! nvdsosd ! nvvideoconvert ! x264enc ! qtmux ! filesink location=out.mp4
