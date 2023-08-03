function fibonacci(num: number): number {
  if (num <= 1) {
    return 1;
  }

  return fibonacci(num - 1) + fibonacci(num - 2);
}

let args;
try{
  //@ts-ignore
  args = Deno.args;
}catch(e){
  args = process.argv;
}

const numInput: string = args.at(-1) ?? "1";
const num = parseInt(numInput);

fibonacci(num);
