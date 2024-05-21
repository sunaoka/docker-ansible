# Ansible Docker image

## Usage

```bash
docker run -v ./:/app:ro \
           -v ./.ansible:/root/.ansible \
           -v ~/.ssh:/root/.ssh:ro \
           --rm \
           -it sunaoka/ansible ansible --version
```

## Appendix

- [ansible/ansible](https://github.com/ansible/ansible)
- [Releases and maintenance](https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html)
