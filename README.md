# Wolfram Example Evaluation Function

This repository contains a basic example evaluation function written in Wolfram Language.

## Wolfram Engine License

Wolfram Engine requires a valid license to run. For developing purposes, you can obtain a free Wolfram Engine license. This process is described in the following steps. If you want to read more about licensing, please refer to the [Wolfram Engine Licensing Documentation](https://hub.docker.com/r/wolframresearch/wolframengine).

**1. Sign in or create a Wolfram ID.**

Head over to the [Wolfram Account Portal](https://account.wolfram.com/login/create) and sign in or create a new account.

**2. Get the Wolfram Engine license**

[Obtain the free license](https://www.wolfram.com/engine/free-license/) by following the instructions.

**3. Activate the Wolfram Engine license**

Run the following command and enter your Wolfram Account credentials to generate a password for the license:

```bash
docker run -it wolframresearch/wolframengine
```

While still in the container, run the following command to print the password:

```plain
In[1] := $PasswordFile // FilePrint
1e1d781ed0a3    6520-03713-97466        4304-2718-2K5ATR        5095-179-696:2,0,8,8:80001:20190627
```

This gives you a password that you can copy to a `mathpass` file on your host machine.

**4. Run the Wolfram Engine container**

Run the following command to start the Wolfram Engine container with the license:

```bash
docker run -it --rm -v $(pwd)/mathpass:/home/wolframengine/.WolframEngine/Licensing wolframresearch/wolframengine
```

This command assumes that you have a `mathpass` file in the current directory, and the container is started with the `wolframengine` user.
