# Use the official OWASP Dependency Check Docker image as the base image
FROM owasp/dependency-check:latest
USER root

# Install wget and other necessary utilities
RUN apk add --no-cache wget tar gzip coreutils

# Download and install OpenJDK 11
RUN wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz \
    && tar -xvf openjdk-11.0.2_linux-x64_bin.tar.gz \
    && mv jdk-11.0.2 /usr/local/ \
    && ln -s /usr/local/jdk-11.0.2/bin/java /usr/bin/java \
    && rm openjdk-11.0.2_linux-x64_bin.tar.gz

# Update dependency-check
RUN /usr/share/dependency-check/bin/dependency-check.sh --updateonly --nvdDatafeed=https://dependency-check.github.io/DependencyCheck_Builder/nvd_cache/nvdcve-{0}.json.gz

ENTRYPOINT [ "/usr/share/dependency-check/bin/dependency-check.sh" ]
