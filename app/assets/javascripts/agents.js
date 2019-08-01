$(() => {
  agents()
})

const agents = () => {
  $('.agents').on('click', (e) => {
    e.preventDefault()
    console.log('hello')
    // console.log(fetch(`${$(".user_agents").href.replace("http://localhost:3000", "")}.json`))


  })
}
