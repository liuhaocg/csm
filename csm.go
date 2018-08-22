package csm

import "github.com/douglarek/dbkit/dbc"

// Base is an abstract model.
type Base struct {
	ID        int64         `db:"id" json:"id"`
	CreatedAt dbc.TimeStamp `db:"created_at" json:"createdAt"`
	UpdatedAt dbc.TimeStamp `db:"updated_at" json:"updatedAt"`
	DeletedAt dbc.TimeStamp `db:"deleted_at" json:"deletedAt"`
}
