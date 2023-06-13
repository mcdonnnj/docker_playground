FROM alpine:3.18

ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG USERNAME="test-user"
ARG GROUPNAME=${USERNAME}
ARG USER_HOME="/home/${USERNAME}"

RUN apk --no-cache add redis

RUN addgroup --system --gid ${USER_GID} ${GROUPNAME} \
  && adduser --system --uid ${USER_UID} --home ${USER_HOME} --ingroup ${GROUPNAME} ${USERNAME}

RUN install -d -m 0755 -o ${USERNAME} -g ${GROUPNAME} ${USER_HOME}/output

COPY entrypoint.sh /usr/local/bin

USER ${USERNAME}
WORKDIR ${USER_HOME}
ENTRYPOINT ["entrypoint.sh"]
