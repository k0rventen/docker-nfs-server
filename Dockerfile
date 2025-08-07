FROM alpine:3.22
RUN apk add nfs-utils
COPY --chmod=500 ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]