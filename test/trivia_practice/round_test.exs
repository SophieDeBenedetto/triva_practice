defmodule TrivaPractice.RoundTest do
  use ExUnit.Case
  alias TrivaPractice.Participant
  alias TrivaPractice.Question
  alias TrivaPractice.Round

  test "adds a participant to the registry" do
    Round.start_round
    {:ok, steven}    = Participant.start_link("Steven", self())
    Round.add_participant(steven)
    assert [{_, steven}] = Registry.lookup(Registry.Participants, "participants")
  end

  test "sends the question to all participants in the registry" do
    Round.start_round
    {:ok, steven}    = Participant.start_link("Steven", self())
    {:ok, sophie}    = Participant.start_link("Sophie", self())
    Round.add_participant(steven)
    Round.add_participant(sophie)
    question = Question.new(%{
                prompt: "What does the fox say?",
                options: ["woof", "meow", "???"],
                correct_answer: "???"
              })

    Round.send_question(question)
    sophie_question = Participant.get_question(sophie)
    steven_question = Participant.get_question(steven)
    assert sophie_question == question
    assert steven_question == question
  end
end
