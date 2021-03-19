import consumer from '../channels/consumer.js';

const SUBSCRIBER = consumer.subscriptions.create({
  channel: "SpaceChannel",
  space: "tv_mv"
})

SUBSCRIBER.received = function (data) {
}