package main
import ("fmt"
	"github.com/novalagung/golpal")
func main(){
	var exprecion string
	fmt.Scanln(&exprecion)
	expr,_:=golpal.New().ExecuteSimple(exprecion)
	fmt.Println(expr)
}