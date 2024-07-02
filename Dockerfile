# Use the official OWASP Dependency Check Docker image as the base image
FROM owasp/dependency-check:latest
USER root

# Install any additional dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*  \
    && /usr/share/dependency-check/bin/dependency-check.sh --updateonly --nvdDatafeed=https://dependency-check.github.io/DependencyCheck_Builder/nvd_cache/nvdcve-{0}.json.gz
ENTRYPOINT [ "/usr/share/dependency-check/bin/dependency-check.sh"]
