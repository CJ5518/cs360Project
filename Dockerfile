FROM ubuntu:latest

RUN curl -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
RUN tar zxf lua-5.1.5.tar.gz
RUN cd lua-5.1.5/
RUN make linux
RUN make install
RUN cd ..
RUN rm lua-5.1.5.tar.gz
RUN apt install luarocks sqlite3 sqlite3-tools openssl
RUN apt install libssl-dev
RUN luarocks install lapis
RUN apt-get -y install --no-install-recommends wget gnupg ca-certificates
RUN wget -O - https://openresty.org/package/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/openresty.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/openresty.list > /dev/null
RUN apt-get update
RUN apt-get -y install openresty
RUN apt install sqlite3 libsqlite3-dev
RUN luarocks install lsqlite3
CMD ["lapis", "serve"]