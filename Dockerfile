# MULTISTEP Dockerfile


# STEP 1
# When we deploy to AWS this currently will fail quindi non va messo
FROM node:alpine 

WORKDIR /usr

COPY package.json .
RUN npm install
COPY . .

CMD ["npm","run","buld"]

# STEP 2
# ci interessa solo il risultato di /app/build generato

FROM nginx

# AWS ha bisogno di questa variabile per capire su che porta andare
EXPOSE 80
# Per copiare da uno step precedente si utilizza il --from=nome assegnato allo step precedente, per il deploy su AWS possiamo utilizzare il suo implicito che è '0'
COPY --from=0 /app/build /usr/share/ngnix/html