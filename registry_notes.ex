alias TrivaPractice.Participant
alias TrivaPractice.Question

{:ok, steven} = Participant.start_link("Steven", self())
{:ok, sophie} = Participant.start_link("Sophie", self())

Participant.get_question(sophie)

{:ok, _} = Registry.start_link(keys: :duplicate, name: Registry.Participants)
{:ok, _} = Registry.register(Registry.Participants, "participants", sophie)
{:ok, _} = Registry.register(Registry.Participants, "participants", steven)
question =  Question.new(%{
              prompt: "What does the fox say?",
              options: ["woof", "meow", "???"],
              correct_answer: "???"
            })

Registry.dispatch(Registry.Participants, "participants", fn participants ->
  for {pid, participant} <- participants, do: Participant.send_question(participant, question)
end)
