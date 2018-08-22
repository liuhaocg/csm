package chat

import (
	"git.xzlcorp.com/backend/csm"
	"github.com/douglarek/dbkit/dbc"
	"github.com/gocraft/dbr"
)

// Chat module
type Chat struct {
	csm.Base
	From    int64         `db:"from" json:"from"`
	To      int64         `db:"to" json:"to"`
	Content dbc.JSONText  `db:"content" json:"content"`
	ReadAt  dbc.TimeStamp `db:"read_at" json:"readAt"`
}

// SendMessage sends a message from one to another.
func SendMessage(s *dbr.Session, from, to int64, content []byte) (*Chat, error) {
	c := Chat{From: from, To: to, Content: content}
	q, vals := s.InsertInto("s_chat.t_chat").Columns("from", "to", "content").Record(&c).ToSql()
	if _, err := s.SelectBySql(q+" RETURNING *", vals...).Load(&c); err != nil {
		return nil, err
	}
	return &c, nil
}

// Messages returns doctor and patient chats.
func Messages(s *dbr.Session, from, to int64, page, perPage int) (ct []Chat) {
	s.Select("*").From("s_chat.t_chat").Where(dbr.And(dbr.Eq("from", from), dbr.Eq("to", to), dbr.Eq("deleted_at", nil))).
		Limit(uint64(perPage)).Offset(uint64(page * perPage)).OrderBy("-id").Load(&ct)
	return
}
