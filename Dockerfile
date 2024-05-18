FROM ghcr.io/lambda-feedback/evaluation-function-base/wolfram:latest

# Command to start the evaluation function with
ENV FUNCTION_COMMAND="wolframscript"

# Args to start the evaluation function with
ENV FUNCTION_ARGS="-f,/app/evaluation_function.wl"

# Interface to use for the evaluation function
ENV FUNCTION_INTERFACE="file"

ENV LOG_LEVEL="DEBUG"

# Copy the evaluation function to the app directory
COPY ./evaluation_function.wl /app/evaluation_function.wl

RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=wolframresearch/wolframengine:12.3.1 \
    /usr/local/Wolfram/WolframEngine/12.3/SystemFiles/Libraries/Linux-x86-64/libiomp5.so \
    /usr/local/Wolfram/WolframEngine/13.3/SystemFiles/Libraries/Linux-x86-64/libiomp5.so