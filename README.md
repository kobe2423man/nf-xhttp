# nf-xhttp

Northflank 部署版：VLESS + xHTTP + Cloudflare 固定隧道（Argo），基于 eishare/Node.js 的「1. Argo XHTTP+TUIC」变体改造。

- 传输：xHTTP（上下行分离），生成 H2 与 H3 两条节点链接
- 隧道：固定隧道，协议 quic（H3），连接数 1
- TUIC 直连：未启用（Northflank 免费档无公网 UDP 端口）
- 改动点：index.js 最高内存档上限由 200/200/350MiB 压至 80/80/160MiB，适配 512MB 容器

## Northflank 环境变量

| 变量 | 值 |
| --- | --- |
| ARGO_DOMAIN | sss.lolmf.dpdns.org |
| ARGO_AUTH | （隧道 token，只存 Northflank 环境变量，不入库） |
| ARGO_PROTOCOL | quic |
| ARGO_CONNECTIONS | 1 |
| ARGO_PORT | 8001 |
| UUID | 5dedc0eb-ead9-4a08-8fee-b6e2999061e5 |
| CFIP | www.teamviewer.com（优选域名，可换） |

容器内部：xray 监听 127.0.0.1:8001（xHTTP 回源），cloudflared 以 token 模式外连隧道。
节点链接在服务日志/sub.txt 中生成：路径为 /<UUID>-xhttp，白天用 H2、晚高峰用 H3。
