# alpine 3.11
FROM node:12-alpine as base

# set working directory
WORKDIR /app

# Commenting out browserless, doesn't work on karma locally, so giving up
# on getting it to run headless on Alpine
# RUN apk add --no-cache \
#      chromium \
#      nss \
#      freetype \
#      freetype-dev \
#      harfbuzz \
#      ca-certificates \
#      ttf-freefont

# ENV CHROME_BIN /usr/bin/chromium-browser

# Please stop doing things like making us copy things out of separate folders while
# also including a private nuget feed. I'm sure there's a good reason for it, but it is
# like Chinese water torture. <3 you!
COPY package.json speak-ng-bcl-0.8.0.tgz speak-styling-0.9.0-r00078.tgz /app/

RUN echo "npm install running in silent, this may take some time" \
    && npm config set @speak:registry=https://sitecore.myget.org/F/sc-npm-packages/npm/ \
    && npm config set @sitecore:registry=https://sitecore.myget.org/F/sc-npm-packages/npm/ \
    && npm install -g @angular/cli@1.5.6 -s \
    && npm install -s

COPY . /app

FROM base as build
RUN ng build -prod

# Cannot get this running on even Windows locally without a browser, let alone headless, runs 0 out of 0 specs
# ignoring this now
# FROM build as test
# ENV CHROME_BIN /usr/bin/chromium-browser
# WORKDIR /app/test
# COPY --from=build /app/dist/sdk .
# RUN ng test

# this correctly fails 
# FROM test as e2e
# WORKDIR /app/e2e
# COPY /app/dist .
# RUN ng e2e

# nginx 1.16.1
# alpine 3.10
FROM nginx:stable-alpine as final
ENV AUTHORING_URI "http://authoringuri"
ENV IDENTITY_URI "http://identityuri"
ENV BIZFX_URI "http://bizfixuri"
ENV LANGUAGE "EN"
ENV CURRENCY "USD"
ENV SHOP_NAME "HabitatShops"
#COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/gzip.conf /etc/nginx/gzip.conf
COPY --from=build /app/dist/sdk /app
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
