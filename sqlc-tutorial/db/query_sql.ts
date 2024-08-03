import mysql, { RowDataPacket } from "mysql2/promise";

type Client = mysql.Connection | mysql.Pool;

export const getAuthorQuery = `-- name: GetAuthor :one
SELECT id, name, bio FROM authors
WHERE id = ? LIMIT 1`;

export interface GetAuthorArgs {
    id: number;
}

export interface GetAuthorRow {
    id: number;
    name: string;
    bio: string | null;
}

export async function getAuthor(client: Client, args: GetAuthorArgs): Promise<GetAuthorRow | null> {
    const [rows] = await client.query<RowDataPacket[]>({
        sql: getAuthorQuery,
        values: [args.id],
        rowsAsArray: true
    });
    if (rows.length !== 1) {
        return null;
    }
    const row = rows[0];
    return {
        id: row[0],
        name: row[1],
        bio: row[2]
    };
}

export const listAuthorsQuery = `-- name: ListAuthors :many
SELECT id, name, bio FROM authors
ORDER BY name`;

export interface ListAuthorsRow {
    id: number;
    name: string;
    bio: string | null;
}

export async function listAuthors(client: Client): Promise<ListAuthorsRow[]> {
    const [rows] = await client.query<RowDataPacket[]>({
        sql: listAuthorsQuery,
        values: [],
        rowsAsArray: true
    });
    return rows.map(row => {
        return {
            id: row[0],
            name: row[1],
            bio: row[2]
        };
    });
}

export const createAuthorQuery = `-- name: CreateAuthor :exec
INSERT INTO authors (
  name, bio
) VALUES (
  ?, ?
)`;

export interface CreateAuthorArgs {
    name: string;
    bio: string | null;
}

export async function createAuthor(client: Client, args: CreateAuthorArgs): Promise<void> {
    await client.query({
        sql: createAuthorQuery,
        values: [args.name, args.bio]
    });
}

export const createAuthorReturnIdQuery = `-- name: CreateAuthorReturnId :execlastid
INSERT INTO authors (
  name, bio
) VALUES (
  ?, ?
)`;

export interface CreateAuthorReturnIdArgs {
    name: string;
    bio: string | null;
}

export const deleteAuthorQuery = `-- name: DeleteAuthor :exec
DELETE FROM authors
WHERE id = ?`;

export interface DeleteAuthorArgs {
    id: number;
}

export async function deleteAuthor(client: Client, args: DeleteAuthorArgs): Promise<void> {
    await client.query({
        sql: deleteAuthorQuery,
        values: [args.id]
    });
}

