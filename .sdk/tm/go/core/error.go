package core

type FreeSportsError struct {
	IsFreeSportsError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewFreeSportsError(code string, msg string, ctx *Context) *FreeSportsError {
	return &FreeSportsError{
		IsFreeSportsError: true,
		Sdk:              "FreeSports",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *FreeSportsError) Error() string {
	return e.Msg
}
