# sena-- 

Esta linguagem está sendo desenvolvida na disciplina de compiladores. A linguagem ainda não está completa, aceita apenas tipo int que internamente é convertido para float e o tipo float.

#### Marcadores de início e fim do programa
```
inicio
    @@ código 
    @@ ...
fim
```

#### Comentários
```
@@ para comentar uma linha, adicione dois arrobas na frente da linha
```

#### Tipos
- real: aceita um número inteiro `a << 10` ou real `a << 10.0`

#### Declaração de variáveis
- com um caractere
```
real a
```
- mais de um caractere
```
real soma 
```
- misturando letras e números
```
real soma1
```
- mais de uma variável
```
real x, y, area
```

#### Atribuição de valores
```
real a << 5
real b, soma

b << 10.0
soma << a * b
```

#### Operação de escrita
```
escreva("Hello Word!")
escreva(a)
escreva(5.0)
escreva(a + b)
```

#### Operação de leitura
```
real idade
escreva("Digite sua idade: ")
leia(idade)
```

#### Operações matemáticas
```
escreva("Soma: ")
escreva(5.0 + 10)

escreva("Subtração: ")
escreva(5.0 - 10)

escreva("Multiplicação: ")
escreva(5.0 * 10)

escreva("Divisão: ")
escreva(5.0 / 10)

escreva("Exponenciação: ")
escreva(5.0 ^ 10)

escreva("Radiciação: ")
escreva(raiz(4))
```

#### Expressões matemáticas e precedência
##### Ordem de precedência
- 1°: Parênteses 
- 2°: Exponenciação
- 3°: Multiplicação e divisão tem mesmo grau de precedência
- 4°: Soma e subtração tem mesmo grau de precedência

```
escreva(((a / b) + (a * b) - 1))
```

#### Exemplo 
```
inicio

  real b
  real h
  real area

  escreva("Cálculo da área do retângulo")
  escreva("") @@ pular linha

  escreva("Digite a base: ")
  leia(b)

  escreva("Digite a altura: ")
  leia(h)

  escreva("")
  escreva("A área do retângulo é: ")
  area << h * b
  escreva(area)

fim
```
