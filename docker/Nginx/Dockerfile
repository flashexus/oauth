# nginx/Dockerfile
 
FROM nginx:1.17.4
 
# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*
 
# Nginxの設定ファイルをコンテナにコピー
ADD nginx.conf /etc/nginx/conf.d/Ro6MysNgx.conf

# Add ssl file
ADD ssl /etc/nginx/ssl
 
# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
