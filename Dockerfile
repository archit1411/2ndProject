FROM centos
WORKDIR /home/root
COPY gencsv.sh ./
RUN sh gencsv.sh
FROM nginx
WORKDIR /usr/share/nginx/html
RUN rm *.html
COPY --from=0 /home/root/actual_inputfile ./
RUN mv actual_inputfile index.html


