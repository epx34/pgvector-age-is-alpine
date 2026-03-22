# Postgres 17 + PostGIS + pgvector + Apache AGE

Imagem Docker personalizada baseada no PostgreSQL 17, já configurada
com extensões comuns para geoprocessamento (PostGIS), vetores (pgvector)
e grafos (Apache AGE). Ideal para desenvolvimento e testes locais que
dependem dessas funcionalidades.

**Conteúdo do repositório**
- `Dockerfile` — instruções para construir a imagem.
- `init-extensions.sql` — script de inicialização que habilita as extensões.

**Principais features**
- PostgreSQL 17 configurado para desenvolvimento.
- Extensões: PostGIS, pgvector e Apache AGE prontas para uso.
- Volumes para persistência de dados.

Requisitos
- Docker (versão compatível com imagens base recentes)

Uso rápido

1) Construir a imagem (substitua `SEUUSUARIO` pelo seu usuário Docker Hub):

```
docker build -t SEUUSUARIO/postgres17-postgis-pgvector-age:1.0.0 .
```

2) Executar o container (exemplo básico):

```
docker run -d \
  --name pg17-ext \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=postgres \
  -p 5433:5432 \
  -v pg17_ext_data:/var/lib/postgresql/data \
  SEUUSUARIO/postgres17-postgis-pgvector-age:1.0.0
```



Exemplo com credenciais customizadas:

```
docker run -d \
  --name pg17-ext \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=senhaforte \
  -e POSTGRES_DB=appdb \
  -p 5433:5432 \
  -v pg17_ext_data:/var/lib/postgresql/data \
  SEUUSUARIO/postgres17-postgis-pgvector-age:1.0.0
```

Publicar no Docker Hub

```
docker login
docker push SEUUSUARIO/postgres17-postgis-pgvector-age:1.0.0
docker push SEUUSUARIO/postgres17-postgis-pgvector-age:latest
```

Variáveis de ambiente suportadas
- `POSTGRES_USER` — usuário do banco (padrão: `postgres`)
- `POSTGRES_PASSWORD` — senha do usuário (obrigatório em produção)
- `POSTGRES_DB` — nome do banco criado por padrão (padrão: `postgres`)

Volumes e portas
- Porta exposta no host: `5433` mapeada para `5432` do container.
- Volume nomeado `pg17_ext_data` para persistência dos dados em
  `/var/lib/postgresql/data`.

Extensões e inicialização
O arquivo `init-extensions.sql` é executado na inicialização para habilitar
as extensões necessárias (PostGIS, pgvector, AGE). Verifique o arquivo se
quiser adicionar ou ajustar extensões e permissões.

Conectar ao banco

```
psql -h localhost -p 5433 -U postgres -d postgres
```

Substitua as credenciais conforme o container que estiver executando.

Boas práticas
- Não use credenciais fracas em ambientes de produção.
- Para produção, considere configurar backups automáticos e monitoramento.

Contribuição
- Abra issues para bugs e sugestões.
- PRs bem descritos são bem-vindos.

Manutenção e contato
- Mantainer: projeto local

Licença
- Consulte o proprietário do repositório para detalhes de licença.

---
Arquivo atualizado com instruções mais claras e estrutura profissional.