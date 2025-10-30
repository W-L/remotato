FROM ubuntu:24.04

# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Create a normal user
RUN useradd -m -s /bin/bash user

# Copy your SSH public key into the container
COPY remotato_key.pub /home/user/.ssh/authorized_keys

# Set correct permissions
RUN chown -R user:user /home/user/.ssh && \
    chmod 700 /home/user/.ssh && \
    chmod 600 /home/user/.ssh/authorized_keys

# Enable public key auth and disable password auth
RUN sed -i 's/#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's@#AuthorizedKeysFile.*@AuthorizedKeysFile /home/user/.ssh/authorized_keys@' /etc/ssh/sshd_config   && \
    sed -i 's/#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config 
    # sed -i 's/#\?PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
    


# Expose SSH port
EXPOSE 22

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
