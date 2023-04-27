FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -y install make gcc curl libreadline-dev
RUN curl -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
RUN tar zxf lua-5.1.5.tar.gz
RUN make -C lua-5.1.5 linux
RUN make -C lua-5.1.5 install
RUN rm lua-5.1.5.tar.gz
RUN apt-get -y install luarocks sqlite3 sqlite3-tools openssl
RUN apt-get -y install libssl-dev
RUN luarocks install lapis
RUN apt-get -y install --no-install-recommends wget gnupg ca-certificates
RUN wget -O - https://openresty.org/package/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/openresty.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/ubuntu jammy main" | tee etc/apt/sources.list.d/openresty.list > /dev/null
RUN apt-get update
RUN apt-get -y install openresty
RUN apt-get -y install sqlite3 libsqlite3-dev
RUN luarocks install lsqlite3
RUN apt-get -y install git
RUN git clone https://github.com/CJ5518/cs360Project
RUN chown -R 1001:1001 cs360Project/
RUN chmod 777 cs360Project/
RUN ls -lR > cs360Project/static/output.txt
WORKDIR "cs360Project"
RUN git config --global --add safe.directory /cs360Project
RUN git pull
RUN chmod 777 /cs360Project/dev_database.sqlite
EXPOSE 8080
CMD ["lapis", "serve"]