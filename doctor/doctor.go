package doctor

import "git.xzlcorp.com/backend/csm"

// Doctor model.
type Doctor struct {
	csm.Base
	UserID      int64  `db:"user_id" json:"userId"`
	Title       string `db:"title" json:"title"`
	IsCertified bool   `db:"is_certified" json:"isCertified"`
}
