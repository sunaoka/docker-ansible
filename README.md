# Ansible Docker image

## Usage

```bash
docker run -v ./:/app:ro \
           -v ./.ansible:/root/.ansible \
           -v ~/.ssh:/root/.ssh:ro \
           -w /app \
           --rm \
           -it sunaoka/ansible ansible --version
```

### Ansible-lint

```bash
docker run -v ./:/app:ro \
           -w /app \
           --rm \
           -it sunaoka/ansible ansible-lint site.yml
```

## Appendix

- [ansible/ansible](https://github.com/ansible/ansible)
- [ansible/ansible-lint](https://github.com/ansible/ansible-lint)
- [Releases and maintenance](https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html)
