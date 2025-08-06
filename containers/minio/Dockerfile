FROM minio/minio:latest

# ポート9000と9001を公開
EXPOSE 9000 9001

# MinIOサーバーを起動
CMD ["server", "/export", "--console-address", ":9001"] 