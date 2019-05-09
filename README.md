# Ansible Playbook to Deploy GitLab Runner

Note that this playbook only tested in openSUSE Leap 15.1

## Prepare the VM/Server

You should prepare the VM/Server yourself. You could use the `clone.sh` script if you already has VM named `leap15.1` in your KVM Virtualization server.

If you just install minimal version of openSUSE Leap 15.1, may be you should install `python` and `python-xml` first. Thus package is needed by the **zypper ansible module**.

```
ansible all -i hosts -m raw -a "zypper install -y python python-xml" -u your-leap-user-name --become --become-user root --ask-become-pass
```

## How to use

Clone the repository to local machine/ansible controller:

```
git clone URL
cd directory-name
```

Copy the required file:

```
cp  hosts.example hosts
cp groups_vars/all.yml.example groups_vars/all.yml
 ```

Example of **hosts** file :

```
[runner]
runner01 ansible_host=10.1.1.220
runner02 ansible_host=10.1.1.221
runner03 ansible_host=10.1.1.222
```

Example of ansible variable file **all.yml**

```
runner_user: gitlab-runner
runner_timezone: Asia/Jakarta
runner_host_user: samsul
runner_registration_token: XXXEy5nG9jHQXXXXXXXX
runner_concurrent: 1
runner_coordinator_url: https://gitlab.com/
runner_description: The runner with the name
runner_executor: docker
runner_docker_image: alpine
runner_tags:
    - dot
    - docker
runner_path: /usr/local/bin/gitlab-runner
```

Run the playbook

```
ansible-playbook -i hosts main.yml --ask-sudo-pass
```
type the sudo password and press Enter. You can omit the `--ask-sudo-pass` if you already set the sudo without password.

If anything goes perfectly as expected, now is the time to register our runner. Go to your gitlab instance, either is gitlab.com or your own gitlab instance :

1. in your project/group, go to **Settings** > **CI/CD** > Expand the **Runner** section,
2. copy your **runner registration token**,
3. back to your playbook, and open the `groups_vars/all.yml` file,
4. paste the token next to `runner_registration_token`,
5. change `runner_coordinator_url` value to your gitlab instance URL if needed, save the file,
6. go back to your terminal, then run:

```
ansible-playbook -i hosts register-runner.yml --ask-sudo-pass
```
7. after the registration is finish, your runner should be available in your gitlab instance.


## License

![Creative Commons Attribution 4.0](https://i.creativecommons.org/l/by/4.0/88x31.png)

This work is licensed under [Creative Commons Attribution 4.0](http://creativecommons.org/licenses/by/4.0/)

## Author

Created with :heart: by [Samsul Ma'arif](https://github.com/samsulmaarif) for you, yes, you are.
