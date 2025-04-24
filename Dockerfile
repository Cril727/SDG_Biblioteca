# Usar la imagen base de Tomcat con JDK 24
FROM tomcat:11-jdk17

# Establecer el directorio de trabajo
WORKDIR /usr/local/tomcat/webapps

# Copiar el archivo WAR al contenedor
COPY ROOT.war /usr/local/tomcat/webapps/

# Exponer el puerto 8080
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["catalina.sh", "run"]
