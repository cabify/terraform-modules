# ChangeLog

### 0.1.26
- Fix readiness and liveness probes
- Expose liveness and readiness probe parameters

### 0.1.25
- Upgrade prometheus to v2.6.0

### 0.1.24
- Fix unnoticed typo in 0.1.23

### 0.1.23
- Switch dashes by underscores in parameter names prometheus-port and prometheus-storageclass 

### 0.1.22
- Make resource requirements configurable

### 0.1.22
- Make liveness probe timeouts configurable

### 0.1.21
- Switch default log-level to warn

### 0.1.20
- Update `Prometheus` to 2.5.0
- Add parameter `log-level` to define log levels of the prometheus instance. Defaults to info.
