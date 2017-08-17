# add a base image
FROM lsucrc/crcbase
USER crcuser

# download funwave source code and extract it 
WORKDIR /model
RUN wget --secure-protocol=auto https://fengyanshi.github.io/build/html/_downloads/funwave_tvd_30.zip && \
    unzip funwave_tvd_30.zip

WORKDIR src

# remove -C option to avoid generating C comments
RUN sed -i 's/DEF_FLAGS     = -P -C -traditional/            DEF_FLAGS     = -P -traditional/' Makefile
RUN sed -i '/^\smv/d' Makefile

# compile funwave
RUN make clean
RUN make 

# set up enviroment variable of funwave
ENV PATH $PATH:/model/src
RUN chmod +rx /model/src/mytvd
