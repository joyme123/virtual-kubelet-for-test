FROM joyme/virtual-kubelet:v1.6.0-base

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/bin/kubectl

ENV APISERVER_CERT_LOCATION /vkubelet-mock-0-crt.pem
ENV APISERVER_KEY_LOCATION /vkubelet-mock-0-key.pem
ENV KUBELET_PORT 10250

# Copy the configuration file for the mock provider.
COPY vkubelet-mock-0-cfg.json /vkubelet-mock-0-cfg.json
# Copy the certificate for the HTTPS server.
COPY vkubelet-mock-0-crt.pem /vkubelet-mock-0-crt.pem
# Copy the private key for the HTTPS server.
COPY vkubelet-mock-0-key.pem /vkubelet-mock-0-key.pem

CMD ["/virtual-kubelet"]