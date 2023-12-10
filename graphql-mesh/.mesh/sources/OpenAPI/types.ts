// @ts-nocheck

import { InContextSdkMethod } from '@graphql-mesh/types';
import { MeshContext } from '@graphql-mesh/runtime';

export namespace OpenApiTypes {
  export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  /** The `String` scalar type represents textual data, represented as UTF-8 character sequences. The String type is most often used by GraphQL to represent free-form human-readable text. */
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
  /** Represents date values */
  Date: { input: string; output: string; }
  ObjMap: { input: any; output: any; }
};

export type Query = {
  /** List all books */
  listBooks?: Maybe<Array<Maybe<Book>>>;
  /** Get a book by ID */
  getBookById?: Maybe<Book>;
};


export type QuerygetBookByIdArgs = {
  bookId: Scalars['String']['input'];
};

export type Book = {
  /** Unique identifier of the book */
  id: Scalars['String']['output'];
  /** Title of the book */
  title: Scalars['String']['output'];
  /** Author of the book */
  author?: Maybe<Scalars['String']['output']>;
  /** ISBN of the book */
  isbn?: Maybe<Scalars['String']['output']>;
  /** Date when the book was published */
  publishedDate?: Maybe<Scalars['Date']['output']>;
};

export type HTTPMethod =
  | 'GET'
  | 'HEAD'
  | 'POST'
  | 'PUT'
  | 'DELETE'
  | 'CONNECT'
  | 'OPTIONS'
  | 'TRACE'
  | 'PATCH';

  export type QuerySdk = {
      /** List all books **/
  listBooks: InContextSdkMethod<Query['listBooks'], {}, MeshContext>,
  /** Get a book by ID **/
  getBookById: InContextSdkMethod<Query['getBookById'], QuerygetBookByIdArgs, MeshContext>
  };

  export type MutationSdk = {
    
  };

  export type SubscriptionSdk = {
    
  };

  export type Context = {
      ["OpenAPI"]: { Query: QuerySdk, Mutation: MutationSdk, Subscription: SubscriptionSdk },
      
    };
}
