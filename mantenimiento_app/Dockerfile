# Compilar la aplicacion Flutter Web
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

COPY pubspec.* ./
RUN flutter pub get

COPY . .

ARG API_BASE_URL=http://localhost:8080/api
RUN sed -i "s#http://10\.0\.2\.2:8080/api#${API_BASE_URL}#g" lib/services/api_service.dart lib/screens/login_screen.dart lib/screens/registro_screen.dart \
    && flutter build web --release --base-href /

# Servir los archivos estaticos
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
