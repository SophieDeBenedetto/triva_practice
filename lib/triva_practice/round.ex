defmodule TrivaPractice.Round do
  alias TrivaPractice.Participant
  def start_round do
    Registry.start_link(keys: :duplicate, name: Registry.Participants)
  end

  def add_participant(participant) do
    Registry.register(Registry.Participants, "participants", participant)
  end

  def send_question(question) do
    Registry.dispatch(Registry.Participants, "participants", fn participants ->
      for {pid, participant} <- participants, do: Participant.send_question(participant, question)
    end)
  end

  def check_answers do
  end

  def cleanup do
  end
end
